import "commonReactions/all.dsl";

context 
{
    // declare input variables here
    input phone: string;

    // declare storage variables here 
    input name: string = ""; 
    input teneantname: string = ""; 
    input adress: string = "";
    
}



// lines 28-42 start node 
start node root 
{
    do //actions executed in this node 
    {
        #connectSafe($phone); // connecting to the phone number which is specified in index.js that it can also be in-terminal text chat
        #waitForSpeech(1000); // give the person a second to start speaking 
        #say("greeting"); // and greet them. Refer to phrasemap.json > "greeting"
        wait *; // wait for a response
    }
    transitions // specifies to which nodes the conversation goes from here 
    {
        yes: goto node_2 on #messageHasIntent("yes"); // when Dasha identifies that the user's phrase contains "name" data, as specified in the named entities section of data.json, a transfer to node node_2 happens
        no:  goto call_later on #messageHasIntent("no");
    }
}

node node_2
{
    do
    {
        #say("pleased_meet"); //assign variable $name with the value extracted from the user's previous statement 
         
        
    }
    transitions
    {
        yes: goto smoke_respond on #messageHasIntent("yes");
        no: goto smoke_respond on #messageHasIntent("no");

    }
}

node smoke_respond
{
    do{
        #say("smoke_yes");
        wait*;
    }
    transitions
    {
       sound_tolerence: goto sound_tolerence;
        
    }
}

node sound_tolerence
{
    do
    {
        #say("what_sound"); 
         wait*;
        
    }
    transitions
    {
        one: goto smoke_respond on #messageHasIntent("one");
        two: goto smoke_respond on #messageHasIntent("two");
        three: goto smoke_respond on #messageHasIntent("three");
        four: goto smoke_respond on #messageHasIntent("four");
        five: goto smoke_respond on #messageHasIntent("five");
        six: goto smoke_respond on #messageHasIntent("six");
        seven: goto smoke_respond on #messageHasIntent("seven");
        eight: goto smoke_respond on #messageHasIntent("eight");
        nine: goto smoke_respond on #messageHasIntent("nine");
        ten: goto smoke_respond on #messageHasIntent("ten");

        movingon: goto coapplication;

    }
    
}

node coapplication
{
    do{
        #say("applying_together");
        wait*;
    }
    transitions
    {
       endresponse: goto rate_positive;
        
    }
}






node call_later
{
    do{
        #say("when_callback");
        wait*;
        exit;
    }
    
}








node can_help 
{
    do 
    {
        #say("can_help");
        wait*;
    }
}





node rate_positive
{
    do 
    {
        #sayText("thank you for your time. we will get back to you shortly. Bye!");
        exit;
    }
}



// digressions 

digression how_are_you
{
    conditions {on #messageHasIntent("how_are_you");}
    do 
    {
        #sayText("I'm well, thank you!", repeatMode: "ignore"); 
        #repeat(); // let the app know to repeat the phrase in the node from which the digression was called, when go back to the node 
        return; // go back to the node from which we got distracted into the digression 
    }
}


digression fuckoff
{
    conditions {on #messageHasIntent("fuckoff");}
    do
    {
        #sayText("you did not have to be mean. Bye!");
        exit;
    }
}











digression bye
{
    conditions {on #messageHasIntent("bye");}
    do
    {
        #sayText("Thanks for your time! Bye!");
        exit;
    }
}
