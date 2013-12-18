package splitr.vo {

public class BillVO {

    public var billId:uint;
    public var billType:String;
    public var billTitle:String = "Add title";
    public var billTotal:Number = 0.00;
    public var billGroup:Vector.<PersonVO>; // PersonVO
    public var photoReference:String = "None";
    public var settledState:Boolean = false;

    public function BillVO() {
        billGroup = new Vector.<PersonVO>();
    }

}
}
