//$("#like-btn").on("click", likeById("#postID"));
//$(".post").dblclick(likeById);

function likeById(postId, type) {
    var csrf = $('meta[name="_csrf"]').attr('content');
    $.ajax({
        method: 'POST',
        url: '/v1/like',
        data: {
            //"_id": this.id.toString().split('-like')[0],
            "postID": postId,
            '_csrf': csrf,
            'likeType': type
        }
    })
        .done(function (data) {
            if (data.event) {
                //show_notification(data.msg,'success');
            }
            else {
                //show_notification(data.msg,'danger')
            }

        })
        .fail(function (data) {
            //show_notification('Some error while liking the feed', 'danger')
            console.log(data)
        });
}

function getLikesById(postId) {
    var csrf = $('meta[name="_csrf"]').attr('content');
    $.ajax({
        method: 'POST',
        url: '/v1/getLikes',
        data: {
            //"_id": this.id.toString().split('-like')[0],
            "postID": postId,
            '_csrf': csrf,
            'likeType': type
        }
    })
        .done(function (data) {
            if (data.event) {
                //show_notification(data.msg,'success');
                return data.likes;
            }
            else {
                //show_notification(data.msg,'danger');
                return 0;
            }

        })
        .fail(function (data) {
            //show_notification('Some error while liking the feed', 'danger')
            console.log(data)
        });
}