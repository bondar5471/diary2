<template>
  <draggable class="board">
    <div v-for="list in original_lists" class="col-3" :key="list.id">
      <h4> {{list.name}} </h4>
      <hr/>
      <draggable v-model="list.cards" :options="{group: 'cards'}">
        <div v-for="(card, index) in list.cards" :key="card.id" class="card card-body">
          {{card.name}}
        </div>
      </draggable>
      <div  class="list">
      <textarea v-model="messages[list.id]" class="form-control"></textarea>
      <button v-on:click="submitMessges(list.id)" class="btn btn-primary">Add</button>
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
  listMoved: function(event){
    var data = new FormData
    data.append("list[position]", event.newIndex + 1 )
    Rails.ajax({
      url: '/lists/${this.lists[event.newIndex].id}/move',
      type: "PATCH",
      data: data,
      dataType: "json",
    })
  },
  submitMessges: function(list_id){
    var data = new FormData
    data.append("card[list_id]", list_id)
    data.append("card[name]", this.messages[list_id])

    Rails.ajax ({
      url: "/cards",
      type: "POST",
      data: data,
      dataType: "json",
      success:(data) =>{
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
p {
  font-size: 2em;
  text-align: center;
}
</style>
