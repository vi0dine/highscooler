import React from 'react';
import './InterestCard.styles.scss';
import {Row, Col, Icon, Spin} from 'antd';
import {useLazyQuery} from "@apollo/client";
import {CHECK_RESULT} from "../../graphql/queries/academy_fields";

const InterestCard = ({resource}) => {
    const [checkResult, {data, loading}] = useLazyQuery(CHECK_RESULT, {
        variables: {
            id: resource.id
        },
    });

    return (
        <Row className={'InterestCard'} type={'flex'}>
            <Col span={20}>
                <Row type={'flex'} justify={'start'} align={'middle'}>
                    <Col className={'InterestCard_Name_Container'} span={22}>
                        <span className={'InterestCard_Name_Text'}>{resource.academy.name}</span>
                    </Col>
                </Row>
                {
                    resource.academy.city && (
                        <Row type={'flex'} justify={'start'} align={'middle'}>
                            <Col className={'InterestCard_City_Container'} span={22}>
                                <span className={'InterestCard_City_Text'}>{resource.academy.city}</span>
                            </Col>
                        </Row>
                    )
                }
            </Col>
            <Col
                className={'InterestCard_Button_Container'}
                span={4}
                onClick={checkResult}
            >
                {
                    loading ? (
                        <div style={{textAlign: 'center'}}>
                            <Spin/>
                        </div>
                    ) : (
                        <>
                            {
                                data ? (
                                    <p className={'result'}>{data.recruitmentPoints}</p>
                                ) : (
                                    <>
                                        <Icon type={'eye'} theme={'filled'} className={'InterestCard_Button_Icon'} />
                                        <p>Sprawdź wynik</p>
                                    </>
                                )
                            }
                        </>
                    )
                }
            </Col>
        </Row>
    );
};

export default InterestCard;