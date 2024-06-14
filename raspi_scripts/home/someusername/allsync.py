import asyncio
import sys
import select

with open('/dev/hidg0', 'wb') as hidg0:
    with open('/dev/hidg1', 'wb') as hidg1:
        async def connect_stdin_stdout():
            loop = asyncio.get_event_loop()
            reader = asyncio.StreamReader()
            protocol = asyncio.StreamReaderProtocol(reader)
            await loop.connect_read_pipe(lambda: protocol, sys.stdin.buffer)

            w_transport_debug, w_protocol_debug = await loop.connect_write_pipe(asyncio.streams.FlowControlMixin, sys.stdout.buffer)
            writer_debug = asyncio.StreamWriter(w_transport_debug, w_protocol_debug, reader, loop)

            w_transport_hidg0, w_protocol_hidg0 = await loop.connect_write_pipe(asyncio.streams.FlowControlMixin, hidg0)
            writer_hidg0 = asyncio.StreamWriter(w_transport_hidg0, w_protocol_hidg0, reader, loop)

            w_transport_hidg1, w_protocol_hidg1 = await loop.connect_write_pipe(asyncio.streams.FlowControlMixin, hidg1)
            writer_hidg1 = asyncio.StreamWriter(w_transport_hidg1, w_protocol_hidg1, reader, loop)

            return reader, writer_debug, writer_hidg0, writer_hidg1

        async def main():
            reader, writer_debug, writer_hidg0, writer_hidg1 = await connect_stdin_stdout()
            while True:
                res = await reader.read(1)
                if not res:
                    break
                if res == b'\x01':
                    res = await reader.read(7)
                    if not res:
                        break
                    writer_hidg1.write(b'\0' + res + b'\0\0')
                if res == b'\x02':
                    res = await reader.read(8)
                    if not res:
                        break
                    writer_hidg0.write(res)

        if __name__ == "__main__":
            asyncio.run(main())