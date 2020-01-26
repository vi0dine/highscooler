import React from 'react';
import './FieldCard.styles.scss';
import { Row, Col } from 'antd';

const FieldCard = ({name, description, academiesCounter}) => {
    return (
        <div className={'FieldCard'}>
            <div className={'FieldCard_Counter_Container'}>
                <span className={'FieldCard_Counter_Text'}>{academiesCounter}</span>
            </div>
            <Row type={'flex'} justify={'start'} align={'middle'}>
                <Col className={'FieldCard_Name_Container'} span={22}>
                    <span className={'FieldCard_Name_Text'}>{name}</span>
                </Col>
            </Row>
            <Row type={'flex'} justify={'start'} align={'middle'}>
                <Col className={'FieldCard_Description_Container'} span={22}>
                    <span className={'FieldCard_Description_Text'}>{description}</span>
                </Col>
            </Row>
        </div>
    );
};

export default FieldCard;