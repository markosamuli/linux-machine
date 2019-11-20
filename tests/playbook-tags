#!/usr/bin/env python

import os.path
import sys
import yaml
from collections import OrderedDict


def get_tags_from_playbook(playbook_file):
    tags = []
    playbook_path = os.path.dirname(playbook_file)
    with open(playbook_file) as f:
        playbook = yaml.safe_load(f)
        for item in playbook:
            if 'import_playbook' in item:
                import_playbook = os.path.join(playbook_path,
                                               item['import_playbook'])
                imported_tags = get_tags_from_playbook(import_playbook)
                tags.extend(imported_tags)
            elif 'tags' in item:
                if isinstance(item['tags'], (list, )):
                    tags.extend(item['tags'])
                else:
                    tags.append(item['tags'])
            else:
                print(item)

    # Remove duplicates while maintaining order
    tags = list(OrderedDict.fromkeys(tags))

    if tags.count('always') > 0:
        tags.remove('always')

    if len(tags) == 0:
        sys.stderr.write('%s has no tags\n' % playbook_file)

    return tags


def print_tags_from_playbook(playbook_file):
    for tag in get_tags_from_playbook(playbook_file):
        print(tag)


if __name__ == '__main__':
    if len(sys.argv) > 1:
        print_tags_from_playbook(sys.argv[1])
    else:
        print('error: playbook name missing')
        print('usage: %s [playbook]' % sys.argv[0])
        sys.exit(1)
