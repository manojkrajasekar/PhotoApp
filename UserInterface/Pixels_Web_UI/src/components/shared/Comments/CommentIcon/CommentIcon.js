import React, { Component } from 'react';
import './CommentIcon.css';
import MaterialIcon from 'material-icons-react';

class CommentIcon extends Component {
    render() {
        return (
            // <div>
            //     <svg version="1.1" className="CommentHere" xmlns="http://www.w3.org/2000/svg" x="0px" y="0px"
            //         viewBox="0 0 60 60" >
            //         <path d="M30,1.5c-16.542,0-30,12.112-30,27c0,5.205,1.647,10.246,4.768,14.604c-0.591,6.537-2.175,11.39-4.475,13.689c-0.304,0.304-0.38,0.769-0.188,1.153C0.276,58.289,0.625,58.5,1,58.5c0.046,0,0.093-0.003,0.14-0.01c0.405-0.057,9.813-1.412,16.617-5.338C21.622,54.711,25.738,55.5,30,55.5c16.542,0,30-12.112,30-27S46.542,1.5,30,1.5z M30,53.5c-3.487,0-6.865-0.57-10.075-1.68c4.075-2.546,4.085-2.727,4.081-3.316c-0.002-0.349-0.192-0.682-0.492-0.861c-0.456-0.274-1.042-0.142-1.337,0.29c-0.549,0.435-2.906,1.947-5.016,3.249l0,0c-4.464,2.696-10.475,4.201-13.809,4.88c2.202-3.669,3.091-8.986,3.441-13.16c0.02-0.241-0.048-0.482-0.192-0.677C3.591,38.143,2,33.398,2,28.5c0-13.785,12.561-25,28-25s28,11.215,28,25S45.44,53.5,30,53.5z"/>
            //     </svg>
            // </div>
            <div className="commentIconWrapper">
                <MaterialIcon icon="comment" size="medium"/>
            </div>
        );
    }
}

export default CommentIcon;