import React from 'react';
import './Field.styles.scss';
import BasicLayout from '../../components/layouts/BasicLayout.layout';
import {useRouter} from 'next/router'
import {useQuery} from "@apollo/react-hooks";
import {Row, Col} from 'antd';
import {FIELD_QUERY} from "../../graphql/queries/fields";
import AcademyCard from "../../components/AcademyCard/AcademyCard.component";
import InterestCard from "../../components/InterestCard/InterestCard.component";
import ReviewCard from "../../components/ReviewCard/ReviewCard.component";

const Field = () => {
    const router = useRouter();
    const {id} = router.query;
    const {data, loading, error} = useQuery(FIELD_QUERY, {
        variables: {
            id: id
        },
        onCompleted: (data) => console.log(data),
        onError: (error) => console.log(error.message)
    });

    return !loading && (
        <BasicLayout>
            <Row gutter={[30, 30]} className={'FieldPage'}>
                <Col span={12}>
                    <Row>
                        <Col span={24} className={'FieldPage_Name_Container'}>
                            <span className={'FieldPage_Name_Text'}>{data.field.name}</span>
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
        </BasicLayout>
    );
};

export default Field