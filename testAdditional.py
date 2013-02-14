"""
Each file that starts with test... in this directory is scanned for subclasses of unittest.TestCase or testLib.RestTestCase
"""

import unittest
import os
import testLib

class TestAddUserWithEmptyName(testLib.RestTestCase):
    """Test adding user with empty username"""
    def assertResponse(self, respData, count = 1, errCode = testLib.RestTestCase.SUCCESS):
        """
        Check that the response data dictionary matches the expected values
        """
        expected = { 'errCode' : errCode }
        if count is not None:
            expected['count']  = count
        self.assertDictEqual(expected, respData)

    def testAdd2(self):
        respData = self.makeRequest("/users/add", method="POST", data = { 'user' : '', 'password' : 'password'} )
        self.assertResponse(respData, count = None, errCode = -3)

class TestAddUserWithEmptyPassword(testLib.RestTestCase):
    """Test adding user with empty password"""
    def assertResponse(self, respData, count = 1, errCode = testLib.RestTestCase.SUCCESS):
        """
        Check that the response data dictionary matches the expected values
        """
        expected = { 'errCode' : errCode }
        if count is not None:
            expected['count']  = count
        self.assertDictEqual(expected, respData)

    def testAdd3(self):
        respData = self.makeRequest("/users/add", method="POST", data = { 'user' : 'vic', 'password' : ''} )
        self.assertResponse(respData, count = 1)

class TestAddUserWithLongName(testLib.RestTestCase):
    """Test adding user with name longer than 128 chars"""
    def assertResponse(self, respData, count = 1, errCode = testLib.RestTestCase.SUCCESS):
        """
        Check that the response data dictionary matches the expected values
        """
        expected = { 'errCode' : errCode }
        if count is not None:
            expected['count']  = count
        self.assertDictEqual(expected, respData)

    def testAdd4(self):
        respData = self.makeRequest("/users/add", method="POST", data = { 'user' : 'vic' * 150, 'password' : 'hello'} )
        self.assertResponse(respData, count = None, errCode = -3)

class TestAddUserWithLongPassword(testLib.RestTestCase):
    """Test adding user with password longer than 128 chars"""
    def assertResponse(self, respData, count = 1, errCode = testLib.RestTestCase.SUCCESS):
        """
        Check that the response data dictionary matches the expected values
        """
        expected = { 'errCode' : errCode }
        if count is not None:
            expected['count']  = count
        self.assertDictEqual(expected, respData)

    def testAdd5(self):
        respData = self.makeRequest("/users/add", method="POST", data = { 'user' : 'victor', 'password' : 'hello' * 140} )
        self.assertResponse(respData, count = None, errCode = -4)
        
class TestLoginUser(testLib.RestTestCase):
    """Test login users"""
    def assertResponse(self, respData, count = 1, errCode = testLib.RestTestCase.SUCCESS):
        """
        Check that the response data dictionary matches the expected values
        """
        expected = { 'errCode' : errCode }
        if count is not None:
            expected['count']  = count
        self.assertDictEqual(expected, respData)

    def testLogin1(self):
        respData = self.makeRequest("/users/add", method="POST", data = { 'user' : 'user1', 'password' : 'password'} )
	respData = self.makeRequest("/users/login", method="POST", data = { 'user' : 'user1', 'password' : 'password'} )
	self.assertResponse(respData, count = 2, errCode = 2)
        respData = self.makeRequest("/users/login", method="POST", data = { 'user' : 'user1', 'password' : 'password'} )
        self.assertResponse(respData, count = 3, errCode = 3)
        respData = self.makeRequest("/users/login", method="POST", data = { 'user' : 'user1', 'password' : 'password'} )
        self.assertResponse(respData, count = 4, errCode = 4)

class TestLoginUserWithBadPassword(testLib.RestTestCase):
    """Test login user with wrong password"""
    def assertResponse(self, respData, count = 1, errCode = testLib.RestTestCase.SUCCESS):
        """
        Check that the response data dictionary matches the expected values
        """
        expected = { 'errCode' : errCode }
        if count is not None:
            expected['count']  = count
        self.assertDictEqual(expected, respData)

    def testLogin2(self):
        respData = self.makeRequest("/users/add", method="POST", data = { 'user' : 'u', 'password' : 'password'} )
	respData = self.makeRequest("/users/login", method="POST", data = { 'user' : 'u', 'password' : 'THISAINTTHECORRECTPASS'} )
	self.assertResponse(respData, count = None, errCode = -1)

class TestLoginUserWithBadUsername(testLib.RestTestCase):
    """Test login user with wrong username"""
    def assertResponse(self, respData, count = 1, errCode = testLib.RestTestCase.SUCCESS):
        """
        Check that the response data dictionary matches the expected values
        """
        expected = { 'errCode' : errCode }
        if count is not None:
            expected['count']  = count
        self.assertDictEqual(expected, respData)

    def testLogin3(self):
        respData = self.makeRequest("/users/add", method="POST", data = { 'user' : 'v', 'password' : 'password'} )
	respData = self.makeRequest("/users/login", method="POST", data = { 'user' : 'u', 'password' : 'anotherpassword'} )
	self.assertResponse(respData, count = None, errCode = -1)
