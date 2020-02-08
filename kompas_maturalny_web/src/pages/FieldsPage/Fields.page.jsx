import React from 'react';
import './Fields.styles.scss'
import {Row, Spin} from "antd";
import BasicLayout from "../../layouts/BasicLayout/BasicLayout.layout";
import {useQuery, gql} from "@apollo/client";
import {useHistory} from 'react-router-dom';
import {FIELDS_QUERY} from "../../graphql/queries/fields";
import FieldCard from "../../components/FieldCard/FieldCard.component";
import InfiniteScroll from 'react-infinite-scroller';

const FIELDS_PER_PAGE = 20;

const GET_SEARCH_QUERY = gql`
    {
        query @client
    }
`;

const FieldsPage = () => {
    const history = useHistory();

    const searchQuery = useQuery(GET_SEARCH_QUERY);

    const {data, loading, fetchMore, error} = useQuery(FIELDS_QUERY, {
        variables: {
            query: searchQuery.data.query,
            first: FIELDS_PER_PAGE,
            after: null
        },
        onError: e => console.log(e),
    });

    return (
        <BasicLayout>
            {
                loading ? (
                    <Spin />
                ) : (

                    <div className={'FieldsPage'}>
                        <Row style={{height: '88vh', overflowY: 'auto'}}>
                            <InfiniteScroll
                                initialLoad={false}
                                useWindow={false}
                                className={'Fields_Array'}
                                pageStart={0}
                                loadMore={() => fetchMore({
                                    variables: {
                                        first: data.fields.totalCount - data.fields.edges.length < FIELDS_PER_PAGE
                                            ? FIELDS_PER_PAGE : data.fields.totalCount - data.fields.edges.length,
                                        after: data.fields.pageInfo.endCursor
                                    },
                                    updateQuery: (prev, { fetchMoreResult }) => {
                                        if (!fetchMoreResult) return prev
                                        return {
                                            ...prev,
                                            pageInfo: fetchMoreResult.fields.pageInfo,
                                            fields: {
                                                ...prev.fields,
                                                edges: [...prev.fields.edges, ...fetchMoreResult.fields.edges]
                                            }
                                        }
                                    }
                                })}
                                hasMore={data.fields.edges.length < data.fields.totalCount}
                                loader={<div className="loader" key={0}>Loading ...</div>}
                            >
                                {
                                    !error && data.fields.edges.map(({node}) => (
                                        <FieldCard
                                            key={node.id}
                                            name={node.name}
                                            description={node.description}
                                            academiesCounter={node.academyFields.length}
                                            onClick={() => history.push(`/fields/${node.id}`)}
                                        />
                                    ))
                                }
                            </InfiniteScroll>
                        </Row>
                    </div>
                )
            }
        </BasicLayout>
    );
};

export default FieldsPage;