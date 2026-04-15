#!/usr/bin/env python3
"""Set the current iTerm2 tab title and lock it against app overrides."""

import asyncio
import iterm2
import sys


async def main(connection):
    name = sys.argv[1] if len(sys.argv) > 1 else "claude"
    app = await iterm2.async_get_app(connection)
    session = app.current_terminal_window.current_tab.current_session
    await session.async_set_name(name)
    profile = await session.async_get_profile()
    await profile.async_set_allow_title_setting(False)


iterm2.run_until_complete(main)
