package problem2;

class Script
{
    private int id;
    private int marks;
    
    public Script(int id)
    {
        this.id = id;
    }

    public void SetMarks(int marks)
    {
        this.marks = marks;
    }

    public int GetMarks()
    {
        return marks;
    }

    public int GetID()
    {
        return id;
    }
}
