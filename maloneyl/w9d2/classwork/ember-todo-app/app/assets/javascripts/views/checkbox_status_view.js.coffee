EmberTodoApp.CheckboxStatusView = Ember.Checkbox.extend # we are extending from Ember's native Checkbox class
  isChecked: true
  classNames: ["toggle"] # css
  change: -> @get("controller").toggleStatus() # change: trigger our action on change; need to write toggleStatus function
