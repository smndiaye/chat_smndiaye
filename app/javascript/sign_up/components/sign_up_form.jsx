import React, { Component } from 'react';
import { CheckStatus } from '../../common/utilities';

export default class SignUpForm extends Component {
  constructor() {
    super();
    this.state = {
      username: '',
      sex: 0,
      age: 18,
      country: '',
      city: '',
      password: '',
      password_confirmation: '',
      showFlashError: '',
      errorMessage: ''
    };
    this.errorHandler = this.errorHandler.bind(this);
  }

  componentWillMount() {
  }

  componentDidMount() {
  }

  onSubmit = (e) => {
    e.preventDefault();

    const self = this;
    const { username, sex, age, country, city, password, password_confirmation } = this.state;

    const body = { username, sex, age, country, city, password, password_confirmation };

    let url = '/api/v1/users/new';

    fetch(url, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(body),
      credentials: 'include'
    }).then(CheckStatus)
      .then(() => {
        window.location.href = `/jotaay/mbedmi`;
      })
      .catch((error) => {
        self.errorHandler(error);
      });
  };

  errorHandler(error) {
    if (error.status === 401) {
      window.location.href = '/';
      return;
    }

    this.setState({
      showFlashError: true,
      errorMessage: error.message
    });
  }


  render() {
    const { username, sex, age, country, city, password, password_confirmation } = this.state;
    return (
      <div>
        <form id="sign-up-form" onSubmit={this.onSubmit}>
          <div id="signup-box">
            <div className="left">
              <span className="signup-with">Jotaay<br/>Sign up</span>
              <form className="new_user" id="new_user">

                <label htmlFor="user_age">Age</label>
                <select name="user[age]" id="user_age">
                  <option value="18">18</option>
                  <option value="19">19</option>
                  <option value="20">20</option>
                  <option value="21">21</option>
                </select><br/>

                <div className="age-selector">
                  <input className="sex male" type="radio" value="male" checked="checked" name="user[sex]"
                         id="user_sex_male"/>
                  <label className="sex male" htmlFor="user_male">Male</label>
                  <input className="sex female" type="radio" value="female" name="user[sex]" id="user_sex_female"/>
                  <label className="sex female" htmlFor="user_female">Female</label>
                </div>
                <br/>

                <label htmlFor="user_username">Username</label>
                <input required="required" type="text" name="user[username]" id="user_username"/>

                <label htmlFor="user_country">Country</label>
                <input required="required" type="text" name="user[country]" id="user_country"/>

                <label htmlFor="user_city">City</label>
                <input required="required" type="text" name="user[city]" id="user_city"/>

                <label htmlFor="user_password">Password</label>
                <input placeholder="please enter your password" required="required" type="password"
                       name="user[password]" id="user_password"/>

                <input placeholder="please confirm your password" required="required" type="password"
                       name="user[password_confirmation]" id="user_password_confirmation"/>

                <input type="submit" name="commit" value="Sign Up" data-disable-with="Sign Up"/>
              </form>
            </div>

            <div className="right">
              <span className="signup-with">Jotaay with<br/>social network</span>

              <button className="social-signup facebook">facebook</button>
              <button className="social-signup twitter">Twitter</button>
              <button className="social-signup google">Google</button>
            </div>
          </div>
        </form>
      </div>
    );
  }
}
