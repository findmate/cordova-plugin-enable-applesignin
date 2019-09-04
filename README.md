# cordova-plugin-applesignin
Cordova Plugin for Sign in with Apple

# API

There are two public functions are available. The functions are returning Promises.

isAvailable - checks the availability of the feature. The returned promise is resolving with true for iOS13+

startLogin - starts the login proccess. Returned Promise resolves with the returned login data or rejects with the error message. Cancelled login is also considered as a rejection. 

Example usage:

```
AppleSignIn.startLogin()  
  .then((res) => {
    console.log('success', res)
  })
  .catch((err) => {
    console.log('error', err)
  }) 
```

The retuned object contains the 
```
{
  email: "zoltan@powerednow.com",
  familyName: "Magyar",
  givenName: "Zoltan",
  user: "xxxxxx.4a9eb79a00384d3ab64f9d88902811ec.xxxx",
}
```
