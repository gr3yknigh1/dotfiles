#!/usr/bin/env python

import os.path

face_frames = [
    "( .-.)",
    "( .-.)",
    "( .-.)",
    "( .-.)",
    "( .-.)",
    "( _-_)"
]

home_dir = os.path.expanduser("~")
face_pth = os.path.join(home_dir, ".face")

mode = "r"
frame_index = 0
if not os.path.exists(face_pth):
    mode = "x"
else:
    with open(face_pth, mode=mode) as file:
        frame_index = int(file.read()[0])
    mode = "w"

if frame_index > len(face_frames) - 1:
    frame_index = 0
print(face_frames[frame_index])

with open(face_pth, mode=mode) as file:
    file.write(str(frame_index + 1))

