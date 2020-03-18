trigger AccountDescription on Account (before insert, before update) {
    for(Account a : Trigger.New) {
        if(a.Description == 'This is Testing') {
            a.Description.addError('No testing allowed');
        }
    }
}

//before insert
//before update
//before delete
//after insert
//after update
//after delete
//after undelete