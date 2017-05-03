import sys
import unittest
sys.path.append('..')
import json_stream

class Tests(unittest.TestCase):
    def test_parse(self):
        parser = json_stream.JsonStream()
        parser.write("{ ")
        self.assertEqual(parser.read(), None)
        parser.write("}{\"x\":")
        self.assertEqual(parser.read(), '{ }')
        self.assertEqual(parser.read(), None)
        parser.write("2}")
        self.assertEqual(parser.read(), '{"x":2}')

    def test_error_case(self):
        parser = json_stream.JsonStream()
        parser.write("{}}    2[}           \t\n                           \n")
        self.assertEqual(parser.read(), "{}")
        self.assertEqual(parser.read(), "}")
        self.assertEqual(parser.read().strip(), "2")
        self.assertEqual(parser.read(), "[")
        self.assertEqual(parser.read(), "}")
        self.assertEqual(parser.read(), None)
        parser.write("[]")
        self.assertEqual(parser.read().strip(), "[]")

    def test_the_middle_of_arrays(self):
        parser = json_stream.JsonStream()
        parser.write('{ "array":["this", "thing", "then",')
        self.assertEqual(parser.read(), None)
        parser.write('"the other thing"]}  ')
        self.assertEqual(parser.read(), '{ "array":["this", "thing", "then","the other thing"]}  ')


if __name__ == '__main__':
    unittest.main()

