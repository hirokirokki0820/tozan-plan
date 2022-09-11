import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="companion"
export default class extends Controller {

  static targets = [
                    "add_profile",
                    "full_name",
                    "role",
                    "birthday",
                    "age",
                    "gender",
                    "address",
                    "phone_number",
                    "emergency_contact",
                    "emergency_number",
                    "add_address"
                    ]

  // 「プロフィールの個人情報を利用する」をチェックしたら自動で個人情報が入力される
  addProfile() {

    // 氏名
    const userFullName = JSON.parse(this.full_nameTarget.dataset.json)
    if(this.add_profileTarget.checked === true){
      this.full_nameTarget.value = userFullName
    }else{
      this.full_nameTarget.value = ""
    }

    // 誕生日
    const userBirthday = JSON.parse(this.birthdayTarget.dataset.json).split("-")
    const selects = this.birthdayTarget.querySelectorAll("select")
    const defaultBirthday = ["1990", "1", "1"]
    if(this.add_profileTarget.checked === true){
      for(let i=0; i<selects.length; i++){
        selects[i].value = Number(userBirthday[i])
      }
    }else{
      for(let i=0; i<selects.length; i++){
        selects[i].value = Number(defaultBirthday[i])
      }
    }


    // selects.forEach((select, index) => {
    //   select.value = Number(userBirthday[index])
    // })

    // 年齢
    const userAge = JSON.parse(this.ageTarget.dataset.json)
    if(this.add_profileTarget.checked === true){
      this.ageTarget.value = userAge
    }else{
      this.ageTarget.value = ""
    }

    // 性別
    const userGender = JSON.parse(this.genderTarget.dataset.json)
    const gender = this.genderTarget.querySelectorAll("input")
    if(this.add_profileTarget.checked === true){
      if(userGender === "男"){
        gender[0].checked = true
      }else{
        gender[1].checked = true
      }
    }else{
      gender[0].checked = true
    }

    // 住所
    const userAddress = JSON.parse(this.addressTarget.dataset.json)
    if(this.add_profileTarget.checked === true){
      this.addressTarget.value = userAddress
    }else{
      this.addressTarget.value = ""
    }

    // 電話番号
    const userPhoneNumber = JSON.parse(this.phone_numberTarget.dataset.json)
    if(this.add_profileTarget.checked === true){
      this.phone_numberTarget.value = userPhoneNumber
    }else{
      this.phone_numberTarget.value = ""
    }

    // 緊急連絡先（間柄）
    const userEmergencyContact = JSON.parse(this.emergency_contactTarget.dataset.json)
    if(this.add_profileTarget.checked === true){
      this.emergency_contactTarget.value = userEmergencyContact
    }else{
      this.emergency_contactTarget.value = ""
    }

    // 緊急連絡先の電話番号
    const userEmergencyNumber = JSON.parse(this.emergency_numberTarget.dataset.json)
    if(this.add_profileTarget.checked === true){
      this.emergency_numberTarget.value = userEmergencyNumber
    }else{
      this.emergency_numberTarget.value = ""
    }

    // アドレス帳追加用のチェックボックス
    if(this.add_profileTarget.checked === true){
      this.add_addressTarget.style.display = "none"
    }else{
      this.add_addressTarget.style.display = "block"
    }


  }
}
