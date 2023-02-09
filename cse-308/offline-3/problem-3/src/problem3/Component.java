package problem3;

import java.util.Vector;

public abstract class Component
{
    private Vector<Component> children;
    private String name;

    public Component(String name)
    {
        this.name = name;
        children = new Vector<>();
    }

    public void AddChild(Component child)
    {
        children.add(child);
    }

    public void RemoveChild(int index)
    {
        if(index < children.size())
        {
            for(int i = 0; i < children.get(index).GetChildren().size(); ++i)
            {
                children.get(index).RemoveChild(children.get(index).GetChildren().get(i));
            }

            children.remove(index);
        }
    }

    public void RemoveChild(Component child)
    {
        for(int i = 0; i < child.GetChildren().size(); ++i)
        {
            child.RemoveChild(child.GetChildren().get(i));
        }

        children.remove(child);
    }

    public abstract void PrintDetails();

    public void PrintHeirarchy()
    {
        PrintHeirarchyHelper(0);
    }

    protected abstract void PrintHeirarchyHelper(int depth);

    public String GetName()
    {
        return name;
    }

    public Vector<Component> GetChildren()
    {
        return children;
    }
}