import React from 'react';
import './Field.styles.scss';
import BasicLayout from '../../layouts/BasicLayout/BasicLayout.layout';
import {useParams} from 'react-router-dom'
import {useMutation, useQuery, useApolloClient} from "@apollo/client";
import {Row, Col, Spin} from 'antd';
import {FIELD_QUERY} from "../../graphql/queries/fields";
import InterestCard from "../../components/InterestCard/InterestCard.component";
import ReviewCard from "../../components/ReviewCard/ReviewCard.component";
import SubjectsBars from "../../components/SubjectsBars/SubjectsBars.component";
import {ADD_USER_FIELD} from "../../graphql/mutations/fields";
import {USER_FIELDS_QUERY} from "../../graphql/queries/users";

const FieldPage = () => {
    const client = useApolloClient();
    const {id} = useParams();

    const {data, loading} = useQuery(FIELD_QUERY, {
        variables: {
            id: id
        },
        onError: (error) => console.log(error.message)
    });

    const [addUserField, { loading: adding }] = useMutation(ADD_USER_FIELD,{
        variables: {
            fieldId: id
        },
        update: (cache, { data: { addUserField } }) => {
            const { UserState: { userFields }} = cache.readQuery({ query: USER_FIELDS_QUERY });
            cache.writeQuery({
                query: USER_FIELDS_QUERY,
                data: { UserState: { userFields: [...userFields, addUserField.userField.fieldOfStudy.id] }},
            });
        }
    });

    const UserState = client.readQuery({
        query: USER_FIELDS_QUERY
    });

    return (
        <BasicLayout>
            {
                loading ? (
                    <Spin/>
                ) : (
                    <Row gutter={[30, 30]} className={'FieldPage'}>
                        <Col span={12}>
                            <Row>
                                <Col span={18} className={'FieldPage_Name_Container'}>
                                    <span className={'FieldPage_Name_Text'}>{data.field.name}</span>
                                </Col>
                                <Col span={6}>
                                    {
                                        UserState.UserState.userFields.includes(id) ? (
                                            <div
                                                onClick={addUserField}
                                                className={['FieldPage_InterestButton','remove'].join(' ')}
                                            >
                                                {
                                                    adding ? (
                                                        <Spin/>
                                                    ) : (
                                                        <span className={['FieldPage_InterestButton_Text','remove'].join(' ')}>Usunąć?</span>
                                                    )
                                                }
                                            </div>
                                        ) : (
                                    <div
                                        onClick={addUserField}
                                        className={['FieldPage_InterestButton', 'add'].join(' ')}
                                    >
                                        {
                                            adding ? (
                                                <Spin/>
                                            ) : (
                                                <span className={['FieldPage_InterestButton_Text','add'].join(' ')}>Zainteresowany?</span>
                                            )
                                        }
                                    </div>
                                        )
                                    }
                                </Col>
                            </Row>
                            <Row>
                                <Col span={24} className={'FieldPage_Description_Container'}>
                                    <span className={'FieldPage_Description_Text'}>{data.field.description}</span>
                                </Col>
                            </Row>
                            <Row>
                                <Col span={24}>
                                    <span className={'FieldPage_Reviews_Title'}>Opinie</span>
                                </Col>
                                <Col className={'FieldPage_Reviews_Container'} span={24}>
                                    {
                                        data.field.reviews.map(review => (
                                            <ReviewCard review={review}/>
                                        ))
                                    }
                                </Col>
                            </Row>
                        </Col>
                        <Col span={12}>
                            <Row>
                                <Col span={24}>
                                    <span className={'FieldPage_Academies_Title'}>Uczelnie</span>
                                </Col>
                                <Col className={'FieldPage_Academies_Container'} span={24}>
                                    {
                                        data.field.academies.map(academy => (
                                            <InterestCard
                                                key={academy.id}
                                                resource={academy}
                                            />
                                        ))
                                    }
                                </Col>
                            </Row>
                            <Row type={'flex'}>
                                <Col span={24}>
                                    <span className={'FieldPage_Subjects_Title'}>Przedmioty</span>
                                </Col>
                                <Col className={'FieldPage_Subjects_Container'} span={24}>
                                    <SubjectsBars
                                        subjects={data.field.mostFrequentSubjects.subjects}
                                        total={data.field.mostFrequentSubjects.total}
                                    />
                                </Col>
                            </Row>
                            <Row type={'flex'}>
                                <Col span={24}>
                                    <span className={'FieldPage_Compass_Title'}>Kompas</span>
                                </Col>
                                <Col className={'FieldPage_Compass_Container'} span={24}>

                                </Col>
                            </Row>
                        </Col>
                    </Row>
                )
            }
        </BasicLayout>
    );
};

export default FieldPage;