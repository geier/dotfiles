import re
import urllib2


# tooks this from pazz alot config
# https://github.com/pazz/configs/blob/f120a322c3403348b1b28a9f8b0edfe677861ad8/\
# .config/alot/hooks.py
def github(ui):
    msg = ui.current_buffer.get_selected_message()
    msgtext = str(msg.get_email())
    r = '<img alt="" height="1" src="(https://github.com/notifications/beacon/.*.gif)"'
    beacons = re.findall(r, msgtext)
    if beacons:
        urllib2.urlopen(beacons[0])
        ui.notify('removed from github notifications:\n %s' % beacons[0])
    else:
        ui.notify('no beacon found')


# tooks this from pazz alot config
# https://github.com/pazz/configs/blob/f120a322c3403348b1b28a9f8b0edfe677861ad8/\
# .config/alot/hooks.py
def unsubscribe():
    """
    Unsubscribe from a mailing list.
    This hook reads the 'List-Unsubscribe' header of a mail in thread mode,
    constructs a unsubsribe-mail according to any mailto-url it finds
    and opens the new mail in an envelope buffer.
    """
    from alot.helper import mailto_to_envelope
    from alot.buffers import EnvelopeBuffer
    msg = ui.current_buffer.get_selected_message()
    e = msg.get_email()
    uheader = e['List-Unsubscribe']
    dtheader = e.get('Delivered-To', None)

    if uheader is not None:
        M = re.search(r'<(mailto:\S*)>', uheader)
        if M is not None:
            env = mailto_to_envelope(M.group(1))
            if dtheader is not None:
                env['From'] = [dtheader]
            ui.buffer_open(EnvelopeBuffer(ui, env))
    else:
        ui.notify('focussed mail contains no \'List-Unsubscribe\' header',
                  'error')
