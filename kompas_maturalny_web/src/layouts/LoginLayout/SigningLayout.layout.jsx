import React from "react";
import './SigningLayout.styles.scss';
import { Layout, Row, Col, Divider } from 'antd';

const { Content, Header, Footer } = Layout;

const SigningLayout = ({ children }) => {
    return (
        <Layout className={'SigningLayout'}>
            <Header className={'SigningLayout_Content'}>

            </Header>
            <Content className={'SigningLayout_Content'}>
                <Row type={'flex'} align={'middle'} justify={'center'}>
                    <Col>
                        <img src={'http://via.placeholder.com/200x200'} />
                    </Col>
                </Row>
                <Row type={'flex'} align={'middle'} justify={'center'}>
                    <Col span={6}>
                        <Divider/>
                        { children }
                    </Col>
                </Row>
            </Content>
            <Footer className={'SigningLayout_Footer'}>
                Kompas Maturalny ©2020 Created by vi0dine
            </Footer>
        </Layout>
    );
};

export default SigningLayout;