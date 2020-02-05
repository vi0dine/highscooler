import React from 'react';
import './InterestCard.styles.scss';
import { Row, Col, Icon } from 'antd';

const InterestCard = ({resource}) => {
    return (
        <Row className={'InterestCard'} type={'flex'}>
            <Col span={20}>
                <Row type={'flex'} justify={'start'} align={'middle'}>
                    <Col className={'InterestCard_Name_Container'} span={22}>
                        <span className={'InterestCard_Name_Text'}>{resource.name}</span>
                    </Col>
                </Row>
                {
                    resource.city && (
                        <Row type={'flex'} justify={'start'} align={'middle'}>
                            <Col className={'InterestCard_City_Container'} span={22}>
                                <span className={'InterestCard_City_Text'}>{resource.city}</span>
                            </Col>
                        </Row>
                    )
                }
            </Col>
            <Col className={'InterestCard_Button_Container'} span={4}>
                <Icon type={'check'} className={'InterestCard_Button_Icon'} />
            </Col>
        </Row>
    );
};

export default InterestCard;