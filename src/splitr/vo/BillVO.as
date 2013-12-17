package splitr.vo {

public class BillVO {

    public var billId:uint;
    public var billType:String;
    public var billTitle:String = "Add title";
    public var billTotal:Number = 0.00;
    public var billGroup:Array = []; // PersonVO
    public var settledState:Boolean = false;

    public function BillVO() {}

}
}
