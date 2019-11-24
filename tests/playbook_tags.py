#!/usr/bin/env python
"""Get available tags in Ansible playbooks"""

from pathlib import Path
import sys

# Add project root to to sys.path
FILE = Path(__file__).resolve()
SCRIPTS_DIR, PROJECT_ROOT = FILE.parent, FILE.parents[1]
sys.path.append(str(PROJECT_ROOT))
# Remove the current scripts/ directory from sys.path
try:
    sys.path.remove(str(SCRIPTS_DIR))
except ValueError:  # Already removed
    pass

# pylint: disable=wrong-import-position
from machine.playbook import get_tags_from_playbook  # noqa: E402
# pylint: enable=wrong-import-position


def print_tags_from_playbook(playbook_file):
    """Print tags from Ansible playbook"""
    for tag in get_tags_from_playbook(playbook_file):
        print(tag)


if __name__ == '__main__':
    if len(sys.argv) > 1:
        print_tags_from_playbook(sys.argv[1])
    else:
        print('error: playbook name missing')
        print('usage: %s [playbook]' % sys.argv[0])
        sys.exit(1)
