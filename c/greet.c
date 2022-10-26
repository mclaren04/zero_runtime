int sys_write(int, const char *, int);

static const char error_msg[] = "Incorrect programm call. Correct: ./greet <YOUR_NAME>\n";
static const char hello_msg[] = "Hello, dear ";

static int string_length(const char *str)
{
  const char *p = str;
  for (; *p; p++) {}
  return p - str;
}

int main(int argc, const char **argv)
{
  if (argc != 2) {
    sys_write(1, error_msg, sizeof(error_msg) - 1);
    return 1;
  }

  sys_write(1, hello_msg, sizeof(hello_msg) - 1);
  sys_write(1, argv[1], string_length(argv[1]));
  sys_write(1, "\n", 1);

  return 0;
}
