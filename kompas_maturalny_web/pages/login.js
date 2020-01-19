import React, {useState} from "react";
import { Spin } from 'antd';
import { useCookies } from 'react-cookie';
import SigningLayout from "../components/layouts/SigningLayout.layout";
import LoginForm from "../components/LoginForm.component";
import {useMutation, useApolloClient} from "@apollo/react-hooks";
import {SIGN_IN_USER} from "../graphql/mutations/sign_in_user";
import SignUpForm from "../components/SignUpForm.component";
import {SIGN_UP_USER} from "../graphql/mutations/sign_up_user";

const LoginPage = () => {
    const [newUser, setNewUser] = useState(false);

    const [cookies, setCookie] = useCookies(['token']);
    const client = useApolloClient();

    const [signInUser, loginProps] = useMutation(SIGN_IN_USER,{
        onCompleted({ signInUser }) {
            setCookie('token', signInUser.user.authenticationToken, { path: '/' });
            client.writeData({ data: { isLoggedIn: true } });
            window.location.href = '/'
        }
    });

    const [signUpUser, signUpProps] = useMutation(SIGN_UP_USER,{
        onCompleted: ({ signUpUser }) => {
            setCookie('token', signUpUser.user.authenticationToken);
            client.writeData({ data: { isLoggedIn: true } });
            window.location.href = '/'
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
            <a onClick={() => setNewUser(true)}>Nie masz konta?</a>
        </SigningLayout>
    );
};

export default LoginPage;