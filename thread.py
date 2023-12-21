import threading


    def build_paral(self):
        threads = []
        for i, r in enumerate(self.requirements):
            self.logger.info(f"Create thread for {r.__class__.__name__}")
            x = threading.Thread(target=r.build, args=(i,))
            threads.append(x)
            self.logger.info(f"Start thread for {r.__class__.__name__}")
            x.start()
        
        for index, thread in enumerate(threads):
            self.logger.info(f"Join thread for {self.requirements[index].__class__.__name__}")
            thread.join()

        for stage in self.stages:
            stage()
