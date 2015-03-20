  var ib_arry = [];  
  var ib_arry_index = 0;
  var buttons_length = $(".interests_buttons").length;
  
  $(function id_set(){
    var hidden_val = $("#user_interests").val().split(",");
    ib_arry = hidden_val;
    ib_arry_index = ib_arry.length;
    for(var j=0; j<ib_arry.length; j++){
      var confirm_val = ib_arry[j];
      for(var k=0; k<buttons_length; k++){
        var option_text = $(".interests_buttons").eq(k).text();
        if(confirm_val===option_text){
          $(".interests_buttons").eq(k).attr("raised","true");
        }
      }
    }    
    for(var i=0; i<buttons_length; i++){
      $(".interests_buttons").eq(i).attr("id","ib_"+i);
    }
  });

  $(".interests_buttons").on("click",function(e){
    var current_id = $(this).index();
    var current_text = $("#ib_"+current_id).text();
    var current_target = $(e.currentTarget);
    ib_arry_refresh(current_text,current_target);
  });

  function ib_arry_refresh(ct,ctarget){
    var split = $("#user_interests").val().split(",");
    if(ib_arry.length===0){
      ctarget.attr("raised","true")
      ib_arry[ib_arry_index] = ct;
      ib_arry_index++;
      text_val_input();    
    }
    else{
      if(($.inArray(ct,ib_arry))===-1){        
        if(split.length <=4){
          ctarget.attr("raised","true");
          ib_arry[ib_arry_index] = ct;
          ib_arry_index++;
          text_val_input();          
        }else{
          ctarget.attr("raised","false");
        }
      }else{
        ctarget.attr("raised","false");
        ib_arry.splice($.inArray(ct,ib_arry),1);
        ib_arry_index--;
        text_val_input();
      }
    }       
  }

  function text_val_input(){
    var interests_length = ib_arry.length;
    $("#user_interests").val("");
    for(var i=0; i<interests_length;i++){
      if(i===0){
          $("#user_interests").val($("#user_interests").val()+ib_arry[i]);
        }else{
          $("#user_interests").val($("#user_interests").val()+","+ib_arry[i]);
        }
    }
  }