import React, {useState} from 'react';
import {useRouter} from 'next/router'
import Link from 'next/link';
import './BasicLayout.styles.scss';
import {Layout, Menu, Icon} from 'antd';

const {Sider, Header, Content, Footer} = Layout;

const BasicLayout = ({children}) => {
    const router = useRouter();
    const [collapsed, setCollapsed] = useState(false);

    return (
        <Layout className={'BasicLayout'}>
            <Sider collapsible
                   onCollapse={(state) => setCollapsed(state)}
                   className={'BasicLayout_Sider'}
                   trigger={null}
                   width={"15vw"}
            >
                <Menu
                    defaultSelectedKeys={router.pathname}
                    className={'BasicLayout_Sider_Menu'}>
                    <Menu.Item
                        key="/fields"
                        className={'BasicLayout_Sider_MenuItem'}
                        onClick={() => router.push('/fields')}
                    >
                        {
                            collapsed ? (
                                <Icon type={"book"} theme={"filled"}/>
                            ) : (
                                <span>KIERUNKI</span>
                            )
                        }
                    </Menu.Item>
                    <Menu.Item
                        key="/academies"
                        className={'BasicLayout_Sider_MenuItem'}
                        onClick={() => router.push('/academies')}
                    >
                        {
                            collapsed ? (
                                <Icon type={"bank"} theme={"filled"}/>
                            ) : (
                                <span>UCZELNIE</span>
                            )
                        }
                    </Menu.Item>
                    <Menu.Item
                        key="logout"
                        className={'BasicLayout_Sider_MenuItem'}
                    >
                        {
                            collapsed ? (
                                <Icon type={"poweroff"}/>
                            ) : (
                                <span>WYLOGUJ</span>
                            )
                        }
                    </Menu.Item>
                </Menu>
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