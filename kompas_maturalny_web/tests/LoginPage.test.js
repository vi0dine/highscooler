import { mount } from "enzyme";
import {MockedProvider} from '@apollo/react-testing';
import React from "react";

import LoginPage from "../pages/login";
import LoginForm from "../components/LoginForm.component";
import SignUpForm from "../components/SignUpForm.component";

describe("LoginPage", () => {
    it('should render login form component', () => {
        const loginPage = mount(
            <MockedProvider mocks={[]}>
                <LoginPage />
            </MockedProvider>
        );

        expect(loginPage.containsMatchingElement(<LoginForm/>)).toEqual(true);
    });

    it("should render signup form component when user clicked 'New User?' link", () => {
        const loginPage = mount(
            <MockedProvider mocks={[]}>
                <LoginPage />
            </MockedProvider>
        );

        loginPage.find('a').simulate('click');
        expect(loginPage.containsMatchingElement(<SignUpForm/>)).toEqual(true);
    });
});

describe("LoginForm", () => {
    it('should contains input for email', () => {
        const loginForm = mount(
                <LoginForm />
        );

        expect(loginForm.find('input[name="email"]')).toHaveLength(1)
    });

    it('should contains input for password', () => {
        const loginForm = mount(
            <LoginForm />
        );

        expect(loginForm.find('input[name="password"]')).toHaveLength(1)
    });
});

describe("SignUpForm", () => {
    it('should contains input for username', () => {
        const loginForm = mount(
            <SignUpForm />
        );

        expect(loginForm.find('input[name="username"]')).toHaveLength(1)
    });

    it('should contains input for email', () => {
        const loginForm = mount(
            <SignUpForm />
        );

        expect(loginForm.find('input[name="email"]')).toHaveLength(1)
    });

    it('should contains input for password', () => {
        const loginForm = mount(
            <SignUpForm />
        );

        expect(loginForm.find('input[name="password"]')).toHaveLength(1)
    });
});