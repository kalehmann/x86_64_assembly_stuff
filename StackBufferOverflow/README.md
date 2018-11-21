## StackBufferOverflow

This program can be used to demonstrate a simple buffer overflow. it asks you
for a password. If you enter the correct one (which is ScrtPsswrd) it prints
"You have root access" otherwise "Access denied"

### How does it work?

The password is stored in a 28 bytes buffer on the stack. After that buffer
comes a 4 byte integer variable that describes if you have access or not.

If the entered password is correct, that variable gets set to 1.

At the end there is a check if the variable differs from 0, that decides
which string to print.

That means, if the entered password is longer than 28 bytes, that variable that
describes whether you have access or not is overwritten.

The exploit just enters a 30 byte string. To test this execute
`python3 exploit.py | ./stackbufferoverflow`
