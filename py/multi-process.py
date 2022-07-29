#!/usr/bin/env python
#!nohup --help
#!nohup /usr/bin/python3 yourscript.py &
#!tail -f nohup.out

import multiprocessing as mp
import time
class Process(mp.Process):
    def __init__(self, id):
        super(Process, self).__init__()
        self.id = id
                 
    def run(self):
        time.sleep(1)
        print("id: {}".format(self.id))

p = Process(0)
p.run()
p.join()
p.close()