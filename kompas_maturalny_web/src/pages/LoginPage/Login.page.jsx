import React, {useState} from "react";
import { Spin } from 'antd';
import { useCookies } from 'react-cookie';
import SigningLayout from "../../layouts/LoginLayout/SigningLayout.layout";
import LoginForm from "../../components/LoginForm/LoginForm.component";
import {useMutation, useApolloClient} from "@apollo/client";
import {SIGN_IN_USER} from "../../graphql/mutations/sign_in_user";
import SignUpForm from "../../components/SignUpForm/SignUpForm.component";
import {SIGN_UP_USER} from "../../graphql/mutations/sign_up_user";
import {USER_FIELDS_QUERY} from "../../graphql/queries/users";
import {useHistory} from "react-router";

const LoginPage = () => {
    const [newUser, setNewUser] = useState(false);
    const history = useHistory();

    const [cookies, setCookie] = useCookies(['token']);
    const client = useApolloClient();

    const [signInUser, loginProps] = useMutation(SIGN_IN_USER,{
        onCompleted({ signInUser }) {
            setCookie('token', signInUser.user.authenticationToken, { path: '/' });
            client.writeData({ data: { isLoggedIn: true } });
            history.push('/fields')
        },
        onError: (e) => console.log(e),
        update: (cache, { data: { signInUser } }) => {
            const { UserState: { userFields }} = cache.readQuery({ query: USER_FIELDS_QUERY });
            cache.writeQuery({
                query: USER_FIELDS_QUERY,
                data: { UserState: { userFields: userFields.concat(signInUser.user.userFields.map(f => f.fieldOfStudy.id)) }},
            });
        }
    });

    const [signUpUser, signUpProps] = useMutation(SIGN_UP_USER,{
        onCompleted: ({ signUpUser }) => {
            setCookie('token', signUpUser.user.authenticationToken);
            client.writeData({ data: { isLoggedIn: true } });
            history.push('/fields')
        }
    });

    const loading = loginProps.loading || signUpProps.loading;

    return (
        <SigningLayout>
            {
                loading ? (
                    <Spin />
                ) : (
                    newUser ? <SignUpForm handleSignUp={signUpUser} /> : <LoginForm handleLogin={signInUser} />
                )
            }
            <div className={'SigningLayout_NewUser_Container'}>
                <a className={'SigningLayout_NewUser_Link'} onClick={() => setNewUser(true)}>
                    Nie masz konta?
                </a>
            </div>
        </SigningLayout>
    );
};

export default LoginPage;