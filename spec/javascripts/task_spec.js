describe('Task', function() {
    it("empty body task", function() {
      task = new Task(" ")
      expect(task.list).toBe("MyTask")
    });
  });