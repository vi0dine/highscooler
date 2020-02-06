import React from 'react';
import './AcademyCard.styles.scss';
import { Row, Col } from 'antd';

const AcademyCard = ({name, city, fieldsCounter}) => {
    return (
        <div className={'AcademyCard'}>
            <div className={'AcademyCard_Counter_Container'}>
                <span className={'AcademyCard_Counter_Text'}>{fieldsCounter}</span>
            </div>
            <Row type={'flex'} justify={'start'} align={'middle'}>
                <Col className={'AcademyCard_Name_Container'} span={22}>
                    <span className={'AcademyCard_Name_Text'}>{name}</span>
                </Col>
            </Row>
            <Row type={'flex'} justify={'start'} align={'middle'}>
                <Col className={'AcademyCard_City_Container'} span={22}>
                    <span className={'AcademyCard_City_Text'}>{city}</span>
                </Col>
            </Row>
        </div>
    );
};

export default AcademyCard;