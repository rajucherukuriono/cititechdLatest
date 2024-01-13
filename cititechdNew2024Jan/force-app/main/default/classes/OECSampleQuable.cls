public class OECSampleQuable implements Queueable {
    public List<Order> ordList ; 
    public OECSampleQuable(List<Order> ordList){
        this.ordList = ordList ;  
    }
    public void execute(QueueableContext context) {
        for(Order orr :ordList){
            // Update the Account Name 
            orr.Name = orr.Name + 'sfdcpoint';
        }
        update ordList;
    }
}