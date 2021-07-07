import glob
import os
import time

PUB_FILES_DIR = "/var/www/bayer/docroot/sites/default/files"
start = time.time()
count = 0

os.chdir(PUB_FILES_DIR)
#types = ('*.jpg', '*.jpeg', '*.png')
types = ('*.jpg')

for root, dirnames, filenames in os.walk(PUB_FILES_DIR):
    print("[ Scanning DIR: " + root + " ]")

    files_grabbed = []

 #   for type in types:
    files_grabbed.extend(glob.glob(os.path.join(root, '*.jpg')))
    print("[ Scanning File Found: " + str(len(files_grabbed)) + " ]")

    for img in files_grabbed:
        if os.path.isfile(img):
            try:
                img_metadata = os.popen(
                    "/usr/bin/identify '{}'".format(img)).read()
                count += 1
                print("  - " + img_metadata.strip())
            except IOError:
                print("  - " + img + "| Image having issue")

end = time.time()
hours, rem = divmod(end-start, 3600)
minutes, seconds = divmod(rem, 60)
print("\nProcessed Time: {:0>2}:{:0>2}:{:05.2f}".format(int(hours),int(minutes),seconds))
print("\nTotal files processed: {:0>2}".format(int(count)))
quit()


## How to RUN
##!/bin/bash
#/usr/bin/python get-img-metadata.py > output-01dev.log