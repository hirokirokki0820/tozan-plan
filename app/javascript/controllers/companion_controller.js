import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="companion"
export default class extends Controller {

  static targets = [
                    "full_name",
                    "role",
                    "birthday",
                    "age",
                    "gender",
                    "address",
                    "phone_number",
                    "emergency_contact",
                    "emergency_number",
                    "add_address",
                    "select_addresses",

                    "add_address_book",
                    "full_name2",
                    "birthday2",
                    "age2",
                    "gender2",
                    "address2",
                    "phone_number2",
                    "emergency_contact2",
                    "emergency_number2"
                    ]

  // 「アドレス帳から追加」で名前を選択したら自動で個人情報が入力される
  selectAddressBook(){
    // アドレス超のidを取得
    const selectedValue = this.select_addressesTarget.value
    const addressBooks = JSON.parse(this.select_addressesTarget.dataset.json)

    // 各フォームの要素を格納
    const fullNameForm = this.full_nameTarget
    const birthdayForm = this.birthdayTarget.querySelectorAll("select")
    const defaultBirthday = ["1990", "1", "1"]
    const ageForm = this.ageTarget
    const genderForm = this.genderTarget.querySelectorAll("input")
    const addressForm = this.addressTarget
    const phoneNumberForm = this.phone_numberTarget
    const emergencyContactForm = this.emergency_contactTarget
    const emergencyNumberForm = this.emergency_numberTarget
    const addAddressCheckbox = this.add_addressTarget


    // 「追加」ボタンを押したら個人情報を追加
    // this.add_address_bookTarget.onclick = () =>{
      addressBooks.forEach((addressBook, index) => {
        if(Number(addressBook.id) === Number(selectedValue)){
          // 氏名
          fullNameForm.value = addressBook.full_name

          // 生年月日
          for(let i=0; i<birthdayForm.length; i++){
            birthdayForm[i].value = Number(addressBook.birthday.split("-")[i])
          }
          // 年齢
          ageForm.value = addressBook.age

          // 性別
          if(addressBook.gender === "男"){
            genderForm[0].checked = true
          }else{
            genderForm[1].checked = true
          }

          // 住所
          addressForm.value = addressBook.address

          // 電話番号
          phoneNumberForm.value = addressBook.phone_number

          // 緊急連絡先（間柄）
          emergencyContactForm.value = addressBook.emergency_contact

          // 緊急連絡先の電話番号
          emergencyNumberForm.value = addressBook.emergency_number

          // 「アドレス帳に保存する」 チェックボックス
          addAddressCheckbox.style.display = "none"

        }else if(selectedValue === ""){ // 「選択なし」の場合
          fullNameForm.value = "" // 氏名
          for(let i=0; i<birthdayForm.length; i++){ //生年月日
            birthdayForm[i].value = Number(defaultBirthday[i])
          }
          ageForm.value = "" // 年齢
          genderForm[0].checked = true // 性別
          addressForm.value = "" // 住所
          phoneNumberForm.value = "" // 電話番号
          emergencyContactForm.value = "" // 緊急連絡先
          emergencyNumberForm.value = "" // 緊急連絡先の電話番号
          addAddressCheckbox.style.display = "block"
        }
      })
    // }
  }

  // フォーム入力すると隠しフィールドにも同じ内容がリアルタイムで入力される
  copyFullName() {
    // 住所
    this.full_name2Target.value = this.full_nameTarget.value
  }

  copyAge() {
    // 年齢
    this.age2Target.value = this.ageTarget.value
  }

  copyGender() {
    // 性別
    const genderForm = this.genderTarget.querySelectorAll("input")
    const gender2Form = this.gender2Target.querySelectorAll("input")
    if(genderForm[0].checked === true){
      gender2Form[0].checked = true
    }else{
      gender2Form[1].checked = true
    }
  }

  copyAddress() {
    // 住所
    this.address2Target.value = this.addressTarget.value
  }

  copyPhoneNumber() {
    // 電話番号
    this.phone_number2Target.value = this.phone_numberTarget.value
  }

  copyEmergencyContact() {
    // 緊急連絡先（間柄）
    this.emergency_contact2Target.value = this.emergency_contactTarget.value
  }

  copyEmergencyNumber() {
    // 緊急連絡先の電話番号
    this.emergency_number2Target.value = this.emergency_numberTarget.value
  }



  // 「入力内容をアドレス帳に保存する」をチェックしたら隠しフィールドに入力内容を転写→「登録する」で@address_bookに保存
  // addAddressBook() {
  //   // 氏名
  //   if(this.add_address_bookTarget.checked === true){
  //     this.full_name2Target.value = this.full_nameTarget.value
  //   }else{
  //     this.full_name2Target.value = ""
  //   }

  //   // 誕生日
  //   const birthdayForm = this.birthdayTarget.querySelectorAll("select")
  //   const birthday2Form = this.birthday2Target.querySelectorAll("select")
  //   const defaultBirthday = ["1990", "1", "1"]
  //   if(this.add_address_bookTarget.checked === true){
  //     for(let i=0; i<birthday2Form.length; i++){
  //       birthday2Form[i].value = Number(birthdayForm[i].value)
  //     }
  //   }else{
  //     for(let i=0; i<birthday2Form.length; i++){
  //       birthday2Form[i].value = Number(defaultBirthday[i])
  //     }
  //   }


  //   // // selects.forEach((select, index) => {
  //   // //   select.value = Number(userBirthday[index])
  //   // // })

  //   // 年齢
  //   if(this.add_address_bookTarget.checked === true){
  //     this.age2Target.value = this.ageTarget.value
  //   }else{
  //     this.age2Target.value = ""
  //   }

  //   // 性別
  //   const genderForm = this.genderTarget.querySelectorAll("input")
  //   const gender2Form = this.gender2Target.querySelectorAll("input")
  //   if(this.add_address_bookTarget.checked === true){
  //     if(genderForm[0].checked === true){
  //       gender2Form[0].checked = true
  //     }else{
  //       gender2Form[1].checked = true
  //     }
  //   }else{
  //     gender2Form[0].checked = true
  //   }

  //   // 住所
  //   if(this.add_address_bookTarget.checked === true){
  //     this.address2Target.value = this.addressTarget.value
  //   }else{
  //     this.address2Target.value = ""
  //   }

  //   // 電話番号
  //   if(this.add_address_bookTarget.checked === true){
  //     this.phone_number2Target.value = this.phone_numberTarget.value
  //   }else{
  //     this.phone_number2Target.value = ""
  //   }

  //   // 緊急連絡先（間柄）
  //   if(this.add_address_bookTarget.checked === true){
  //     this.emergency_contact2Target.value = this.emergency_contactTarget.value
  //   }else{
  //     this.emergency_contact2Target.value = ""
  //   }

  //   // 緊急連絡先の電話番号
  //   if(this.add_address_bookTarget.checked === true){
  //     this.emergency_number2Target.value = this.emergency_numberTarget.value
  //   }else{
  //     this.emergency_number2Target.value = ""
  //   }

  // }

  // copyFullName() {
  //   // 氏名
  //   this.full_name2Target.value = this.full_nameTarget.value
  // }

  // copyBirthday() {
  //   // 生年月日
  //   const birthdayForm = this.birthdayTarget.querySelectorAll("select")
  //   const birthday2Form = this.birthday2Target.querySelectorAll("select")
  //     for(let i=0; i<birthday2Form.length; i++){
  //       birthday2Form[i].value = Number(birthdayForm[i].value)
  //     }
  // }

}
