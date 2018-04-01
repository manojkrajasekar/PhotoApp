import React, { Component } from 'react';
import './VoteIcon.css';
import store from '../../../store/configureStore';
import { AddVote } from '../../../actions/votesAction';
import MaterialIcon from 'material-icons-react';

class VoteIcon extends React.Component {
    constructor(props){
        super(props);
        this.state = {
            initial_votes: 1,
            bgColor: 'red',
            isVote: false
        };
    }
    
    onVote = (e, prevState) => {
        e.preventDefault();
        store.dispatch(AddVote());
        this.setState({
            bgColor:'blue',
            isVote:!this.state.isVote
        });
    };
    
    render() {
        return (
            // <div>
            //     <svg onClick ={this.onVote} className="Camera" xmlns="http:www.w3.org/2000/svg" version="1.1" x="0px" y="0px"
            //         viewBox="0 0 51.997 51.997"  >
            //         <title id="title">Vote</title>
            //         <path d="M51.911,16.242C51.152,7.888,45.239,1.827,37.839,1.827c-4.93,0-9.444,2.653-11.984,6.905c-2.517-4.307-6.846-6.906-11.697-6.906c-7.399,0-13.313,6.061-14.071,14.415c-0.06,0.369-0.306,2.311,0.442,5.478c1.078,4.568,3.568,8.723,7.199,12.013l18.115,16.439l18.426-16.438c3.631-3.291,6.121-7.445,7.199-12.014C52.216,18.553,51.97,16.611,51.911,16.242z M49.521,21.261c-0.984,4.172-3.265,7.973-6.59,10.985L25.855,47.481L9.072,32.25c-3.331-3.018-5.611-6.818-6.596-10.99c-0.708-2.997-0.417-4.69-0.416-4.701l0.015-0.101C2.725,9.139,7.806,3.826,14.158,3.826c4.687,0,8.813,2.88,10.771,7.515l0.921,2.183l0.921-2.183c1.927-4.564,6.271-7.514,11.069-7.514c6.351,0,11.433,5.313,12.096,12.727C49.938,16.57,50.229,18.264,49.521,21.261z"/>
            //     </svg>
            // </div>
            <div className="voteIconWrapper" onClick={this.onVote}>
                <div className="tooltip">
                    <span className="tooltiptext">Vote</span>
                </div>
                {this.state.isVote ?
                    <MaterialIcon icon="favorite_border" color="blue" size='medium'/>
                    :
                    <MaterialIcon icon="favorite_border" size='medium' backgroundcolor="red" />
                }
            </div>
        );
    }
}

export default VoteIcon;