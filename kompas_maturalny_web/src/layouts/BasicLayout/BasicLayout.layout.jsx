import React, {useEffect, useState} from 'react';
import {useHistory} from 'react-router-dom';
import './BasicLayout.styles.scss';
import {Layout, Menu, Icon, Input} from 'antd';
import {useApolloClient} from "@apollo/client";

const {Sider, Header, Content, Footer} = Layout;
const {Search} = Input;

const BasicLayout = ({children}) => {
        const history = useHistory();
        const client = useApolloClient();
        const [collapsed, setCollapsed] = useState(false);
        const [query, setQuery] = useState(null);

        useEffect(() => {
            if (query !== null) {
                client.writeData({data: {query: query}})
            }
        }, [query]);

        return (
            <Layout className={'BasicLayout'}>
                <Sider collapsible
                       onCollapse={(state) => setCollapsed(state)}
                       className={'BasicLayout_Sider'}
                       trigger={null}
                       width={"15vw"}
                >
                    <Menu
                        defaultSelectedKeys={history.location.pathname}
                        className={'BasicLayout_Sider_Menu'}>
                        <Menu.Item
                            key="/fields"
                            className={'BasicLayout_Sider_MenuItem'}
                            onClick={() => history.push('/fields')}
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
                            onClick={() => history.push('/academies')}
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
                        <Search
                            onSearch={(q) => {
                                setQuery(q);
                            }}
                        />
                    </Header>
                    <Content>
                        {children}
                    </Content>
                    <Footer>

                    </Footer>
                </Layout>
            </Layout>
        );
    }
;

export default BasicLayout;