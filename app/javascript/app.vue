<template>
  <draggable v-model="lists" :options="{group: 'lists'}" class="board container-full" @end="listMoved">
    <div v-for="list in original_lists" class="col-3" :key="list.id">
      <h4> {{list.name}} </h4>
      <draggable v-model="list.cards" :options="{group: 'cards'}" @change="cardMoved">
        <div v-for="(card, index) in list.cards" :key="card.id" class="card card-body">
          {{card.name}}
          <button v-on:click="cardRemove(card.id)" class="btn btn-danger">Delete</button>
        </div>
      </draggable>
      <div  class="list">
      <textarea v-model="messages[list.id]" class="form-control"></textarea>
      <button v-on:click="submitMessages(list.id)" class="btn btn-primary">Add</button>
      </div>
    </div>
  </draggable>
</template>

<script>
import draggable from "vuedraggable"
export default {
  components: {draggable},
  props: ["original_lists"],
  data: function(){
    return {
      messages: {},
      lists: this.original_lists,
    }
},
methods: {
  cardRemove (card) {
    this.$delete(this.cards, card)
    },
  cardMoved: function(event) {
    const evt = event.added || event.moved
    if (evt == undefined) { return }
    const element = evt.element
    const list_index = this.lists.findIndex((list) => {
      return list.cards.find((card) =>{
        return card.id === element.id
      })
    })
  var data = new FormData
  data.append("card[list_id]", this.lists[list_index].id) 
  data.append("card[position]", evt.newIndex +1)
  Rails.ajax ({
    url: `/cards/${element.id}/move`,
    type: 'PATCH',
    data: data,
    dataType: "json",
    })
  },

  listMoved: function(event){
    debugger;
    console.log(event)
    var data = new FormData
    data.append("list[position]", event.newIndex + 1 )
    Rails.ajax({
      url: `/lists/${this.lists[event.newIndex].id}/move`,
      type: "PATCH",
      data: data,
      dataType: "json",
    })
  },
  submitMessages: function(list_id){
    var data = new FormData
    data.append("card[list_id]", list_id)
    data.append("card[name]", this.messages[list_id])

    Rails.ajax ({
      url: "/cards",
      type: "POST",
      data: data,
      dataType: "json",
      success:(data) => {
        const index = this.lists.findIndex(item => item.id == list_id)
        this.lists[index].cards.push(data)
        this.messages[list_id] = undefined
      }
    })
  }
 }
}

</script>

<style scoped>
 .btn.btn-danger {
   height: 30px;
   width: 70px;
   margin: 5px;
   text-align: center;

 }
</style>
