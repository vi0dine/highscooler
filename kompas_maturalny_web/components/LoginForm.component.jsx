import React from "react";
import { Form, Input, Button } from 'antd';
import * as yup from 'yup';
import {useFormik} from "formik";

const LoginForm = ({ handleLogin }) => {
    const validator = yup.object().shape({
        email: yup.string().email('Podaj prawidłowy adres email').required('Email nie może być pusty'),
        password: yup.string().min(8, 'Hasło musi mieć co najmniej 8 znaków').required('Hasło nie może być puste')
    });

    const formik = useFormik({
        initialValues: {
            email: '',
            password: ''
        },
        validationSchema: validator,
        onSubmit: ({email, password}) => handleLogin({ variables: { email: email, password: password }})
    });

    return (
        <Form onSubmit={formik.handleSubmit}>
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
                ZALOGUJ
            </Button>
        </Form>
    );
};

export default LoginForm;