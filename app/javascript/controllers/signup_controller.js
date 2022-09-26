import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="signup"
export default class extends Controller {
  static targets = [
                    "name",
                    "email",
                    "password",
                    "password_confirmation",
                    "submit",
                    "error_name",
                    "error_email",
                    "error_password",
                    "error_password_confirmation",
                    // "source",
                    // "copy_button"
                    ]

  // this.nameTarget の valueの値を取得
  // → this.nameとして使用
  get name(){
    return this.nameTarget.value
  }

  // copy(event){
  //   event.preventDefault()
  //   navigator.clipboard.writeText(this.sourceTarget.value)
  //   this.copy_buttonTarget.innerHTML = '<i class="bi bi-clipboard-check"></i> Copied!!'
    // clearTimeout(this.timeoutCopy)
    // this.timeoutCopy = setTimeout( ()=> {
    //   this.copy_buttonTarget.innerHTML = '<i class="bi bi-clipboard"></i> Copy to Clipboard'
    // }, 3000)
  // }

  // ユーザー名(表示名)のバリデーション
  nameValidation() {
    const nameInput = this.nameTarget // ユーザー名の input
    const nameError = this.error_nameTarget // エラーメッセージ
    // セットされているTimeoutをクリアする
    clearTimeout(this.timeoutName)

    // 300ms後にリクエストを実行する
    this.timeoutName = setTimeout( ()=> {
      if(this.name === ""){ // 入力フォームが空の場合
        nameInput.style.border = "2px solid red"
        nameError.textContent = "ユーザー名を入力してください"
        nameError.style.color = "red"
      }else{
        nameInput.style.border = "2px solid lightgreen"
        nameError.textContent = ""
      }
    }, 300)
  }

  // Eメールアドレスのバリデーション
  emailValidation() {
    const emailInput = this.emailTarget // Eメールアドレスの input
    const emailError = this.error_emailTarget // エラーメッセージ
    const emailRegex = /^[a-zA-Z0-9_+-]+(\.[a-zA-Z0-9_+-]+)*@([a-zA-Z0-9][a-zA-Z0-9-]*[a-zA-Z0-9]*\.)+[a-zA-Z]{2,}$/ // 正規表現パターン

    // セットされているTimeoutをクリアする
    clearTimeout(this.timeoutEmail)

    this.timeoutEmail = setTimeout( ()=> {
      if(emailInput.value === ""){ // 入力フォームが空の場合
        emailInput.style.border = "2px solid red"
        emailError.textContent = "Eメールアドレスを入力してください"
        emailError.style.color = "red"
      }else if(!emailRegex.test(emailInput.value)){ // 入力した値がemailRegexの正規表現パターンにマッチしない場合
        emailInput.style.border = "2px solid red"
        emailError.textContent = "有効なEメールアドレスを入力してください"
        emailError.style.color = "red"
      }else{ // 正規表現パターンにマッチする場合
        const csrfToken = document.getElementsByName('csrf-token')[0].content // CSRFトークンを取得
        const params = { // 入力したEメールアドレスをパラメータオブジェクトに渡す
          email: emailInput.value,
        }
        const options = { // POSTメソッドを指定, CSRFトークンの設定など
          method: "POST",
          // credentials: 'same-origin',
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
            'X-CSRF-Token': csrfToken
          }
        }
        const query_params = new URLSearchParams(params)
        // users#is_registered?アクション に POSTリクエスト(クリエパラメータでemail情報の送信)
        fetch("/signup/check_email" + "?" + query_params, options)
          .then(response => response.json())
          .then(response => {
            if (response) { // レスポンスにユーザー情報が返ってきた場合（すでにユーザーが存在する場合）
              emailError.textContent = 'すでに登録されているメールアドレスです'
              emailInput.style.border = "2px solid red"
              emailError.style.color = "red"
            }else{ // ユーザーが存在しない場合
              emailInput.style.border = "2px solid lightgreen"
              emailError.textContent = ""
            }
          })
      }
    }, 300)
  }

  // パスワードのバリデーション
  passwordValidation() {
    const passInput = this.passwordTarget // パスワードの input
    const passConfirmInput = this.password_confirmationTarget // パスワード(確認用)の input
    const passError = this.error_passwordTarget // エラーメッセージ
    const passConfirmError = this.error_password_confirmationTarget // エラーメッセージ
    const passRegex = /^([a-zA-Z0-9]{6,})$/ // 正規表現パターン(半角英数字6文字以上)

    // セットされているTimeoutをクリアする
    clearTimeout(this.timeoutPass)
    // パスワードがpassRegexの正規表現パターンに一致しない時の処理
    this.timeoutPass = setTimeout( ()=> {
      if(!passRegex.test(passInput.value)){
        if(passInput.value === ""){ // 入力フォームが空の場合
          passInput.style.border = "2px solid red"
          passError.textContent = "パスワードを入力してください"
          passError.style.color = "red"
          passConfirmInput.style.border = "2px solid red"
          passConfirmError.textContent = ""
        }else{
          passInput.style.border = "2px solid red"
          passError.textContent = "6文字以上の半角英数字で入力してください"
          passError.style.color = "red"
          passConfirmInput.style.border = "2px solid red"
          passConfirmError.textContent = ""
        }
      }else{ // 正規表現パターンに一致した時の処理
        if(passConfirmInput.value === ""){ // 入力フォームが空の場合
          passInput.style.border = "2px solid lightgreen"
          passError.textContent = ""
          passConfirmInput.style.border = "2px solid red"
          passConfirmError.textContent = "パスワード(確認用)を入力してください"
          passConfirmError.style.color = "red"
        }else if(passInput.value === passConfirmInput.value){ // パスワード、パスワード確認用の値が一致する場合
          passInput.style.border = "2px solid lightgreen"
          passError.textContent = ""
          passConfirmInput.style.border = "2px solid lightgreen"
          passConfirmError.textContent = ""
        }else{ // パスワード、パスワード確認用の値が一致しない場合
          passInput.style.border = "2px solid lightgreen"
          passError.textContent = ""
          passConfirmInput.style.border = "2px solid red"
          passConfirmError.textContent = "入力したパスワードと一致しません"
          passConfirmError.style.color = "red"
        }
      }
    }, 300)
  }

// 送信ボタンの有効化
  validSubmit() {
    const submitBtn = this.submitTarget // 送信ボタン

    // セットされているTimeoutをクリアする
    clearTimeout(this.timeoutSubmit)
    this.timeoutSubmit = setTimeout( ()=> {
      if((this.nameTarget.value !== "") && (this.emailTarget.value !== "") && (this.passwordTarget.value !== "") && (this.password_confirmationTarget.value !== "")){ // 全ての入力フォームに値が存在する、且つ ↓
        if((this.error_nameTarget.textContent === "") && (this.error_emailTarget.textContent === "") && (this.error_passwordTarget.textContent === "") && (this.error_password_confirmationTarget.textContent === "")){ // エラーメッセージが全てなくなった場合
          submitBtn.disabled = false // 送信ボタンを有効化
        }else{
          submitBtn.disabled = true
        }
      }else{
        submitBtn.disabled = true
      }
    }, 350)
  }

}
