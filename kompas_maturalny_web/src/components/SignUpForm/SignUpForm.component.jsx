import React from "react";
import { Form, Input, Button } from 'antd';
import * as yup from 'yup';
import {useFormik} from "formik";

const SignUpForm = ({ handleSignUp }) => {
    const validator = yup.object().shape({
        username: yup.string().required('Nazwa użytkownika nie może być pusta.'),
        email: yup.string().email('Podaj prawidłowy adres email.').required('Email nie może być pusty.'),
        password: yup.string().min(8, 'Hasło musi mieć co najmniej 8 znaków.').required('Hasło nie może być puste.')
    });

    const formik = useFormik({
        initialValues: {
            username: '',
            email: '',
            password: ''
        },
        validationSchema: validator,
        onSubmit: ({username, email, password}) => handleSignUp({ variables: { username: username, email: email, password: password }})
    });

    return (
        <Form onSubmit={formik.handleSubmit}>
            <Form.Item
                validateStatus={formik.errors.username ? 'error' : 'success'}
                hasFeedback={formik.touched.username}
                help={formik.errors.username}
            >
                <Input
                    name={'username'}
                    placeholder={'Nazwa użytkownika'}
                    value={formik.values.username}
                    onChange={formik.handleChange}
                    onBlur={formik.handleBlur}
                />
            </Form.Item>
            <Form.Item
                validateStatus={formik.errors.email ? 'error' : 'success'}
                hasFeedback={formik.touched.email}
                help={formik.errors.email}
            >
                <Input
                    name={'email'}
                    placeholder={'Email'}
                    value={formik.values.email}
                    onChange={formik.handleChange}
                    onBlur={formik.handleBlur}
                />
            </Form.Item>
            <Form.Item
                validateStatus={formik.errors.password ? 'error' : 'success'}
                hasFeedback={formik.touched.password}
                help={formik.errors.password}
            >
                <Input
                    name={'password'}
                    type={'password'}
                    placeholder={'Hasło'}
                    value={formik.values.password}
                    onChange={formik.handleChange}
                    onBlur={formik.handleBlur}
                />
            </Form.Item>
            <Button onClick={() => formik.submitForm()}>
                ZAREJESTRUJ
            </Button>
        </Form>
    );
};

export default SignUpForm;