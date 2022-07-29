#!/usr/bin/env python
from os import environ
from typing import Union
from json import loads

def _load_keyfile(
    path_filename_keyfile: str
) -> Union[object, Exception]:
  try:
    with open(path_filename_keyfile, 'r') as j:
      data = loads(j.read())
      environ[data['username']] = data['username']
      environ[data['key']] = data['key']
  except Exception as e:
    print(str(e))
    return e