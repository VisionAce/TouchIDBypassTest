## Keychain解決方案說明
- [程式碼連結][3]

- AccessControl物件：在程式碼的第一部分，我們建立了SecAccessControl物件，它會使用當前的生物識別設定作為驗證的條件。這樣，即使在繞過指紋辨識的情況下，存取Keychain中的資料也無法輕易達成，因為這是透過SecAccessControl進行保護的。
- Keychain保存：第二部分的程式碼將密碼以SecAccessControl物件保護的形式儲存到Keychain中。
- Keychain檢索：在最後一部分中，當用戶嘗試存取資料時，Keychain會觸發生物識別或裝置密碼驗證對話框，如果驗證成功，才會返回儲存的密碼。

**這種方法確保了即使攻擊者設法繞過簡單的驗證邏輯，也無法直接存取敏感的資料，因為這些資料受到系統級別的保護。**

## 📸 YouTube Demo

[![IMAGE ALT TEXT HERE](https://img.youtube.com/vi/OssO0hMyIao/0.jpg)](https://www.youtube.com/watch?v=OssO0hMyIao)

[![IMAGE ALT TEXT HERE](https://img.youtube.com/vi/uV9fKjWspJA/0.jpg)](https://www.youtube.com/watch?v=uV9fKjWspJA)



## 參考連結
- [OWASP][1]
- [解決方案][2]

[1]: https://mas.owasp.org/MASTG/tests/ios/MASVS-AUTH/MASTG-TEST-0064/
[2]: https://github.com/OWASP/owasp-mastg/blob/master/Document/0x06f-Testing-Local-Authentication.md#local-authentication-framework
[3]: https://github.com/VisionAce/TouchIDBypassTest/blob/main/TouchID/DoubleAuthenticate.swift
