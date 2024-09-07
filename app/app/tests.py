"""
Sample tests
"""

from app import calc
from django.test import SimpleTestCase
# from rest_framework.test import APIClient


class CalcTests(SimpleTestCase):
    """
    Test the calc module.
    """

    def test_add_numbers(self):
        res = calc.add(5, 6)

        self.assertEqual(res, 11)

    def test_subtract_numbers(self):
        res = calc.subtract(16, 10)

        self.assertEqual(res, 6)
