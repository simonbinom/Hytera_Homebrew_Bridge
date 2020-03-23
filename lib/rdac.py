from .generic_service import GenericService
from .constants import *


class RDACService(GenericService):
    def __init__(self):
        super().__init__()
        self.listenPort = self.DEFAULT_LISTEN_PORT = DEFAULT_RDAC_PORT

    def run(self) -> None:
        self.create_socket()
        while True:
            try:
                data, address = self.serverSocket.recvfrom(4096)
                ip, port = address
                self.log("data (%d) received from %s.%s" % (len(data), ip, port))
                self.log(data.hex())
            except Exception as err:
                self.selfLogger.error(err, exc_info=True)


if __name__ == "__main__":
    t = RDACService()
    t.start()
