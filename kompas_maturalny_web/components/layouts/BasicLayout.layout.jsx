import React from 'react';
import { Layout, Menu, Icon } from 'antd';

const { Sider, Header, Content, Footer } = Layout;
const { SubMenu } = Menu;

const BasicLayout = ({children}) => {
    return (
        <Layout>
            <Sider>

            </Sider>
            <Layout>
                <Header>

                </Header>
                <Content>
                    {children}
                </Content>
                <Footer>

                </Footer>
            </Layout>
        </Layout>
    );
};

export default BasicLayout;