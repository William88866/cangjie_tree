package tree

import std.collection.*
import std.core.ToString

//struct
//----------------------------------------二叉树---------------------------------------


//来定义一个二叉树


public class Node_tree<T>{
    var val : T  
    var up:Option<Node_tree<T>> = None
    var left:Option<Node_tree<T>> = None
    var right:Option<Node_tree<T>> = None
    init(a:T){
        this.val = a
        this.up = None
        this.left = None
        this.right = None
    }
    public func nextLeft():?Node_tree<T>{
        return this.left
    }
    public func nextRight():?Node_tree<T>{
        return this.right
    }
    public func getVal():T{
        return this.val
    }
    public func getUp():?Node_tree<T>{
        return this.up
    }
}


public class Tree_01<T> <: ToString where T <: ToString{
    var root:?Node_tree<T> = None
    var realAll:ArrayList<T> = ArrayList<T>([])
    init(a:ArrayList<T>){
        this.realAll = a
        this.root = create_tree(a)
    }
    public func toString():String{
        return '${this.realAll}'
    }
    //按照层次建树
    public func create_tree(ly:ArrayList<T>):Option<Node_tree<T>>{
        //index为ly的指针
        var index = 1
        var len = ly.size
        var tmp_que = ArrayList<?Node_tree<T>>([])
        var root_node:Option<Node_tree<T>> = Node_tree<T>(ly[0])
        tmp_que.add(root_node)
        //count为队列的指针
        var count = 0
        while (index+1 <= len){
            if (len - index > 1 ){
                // tmp = tmp_que[0]
                // tmp_que.remove(at:0)
                var node_left:Option<Node_tree<T>> = Node_tree<T>(ly[index])
                index++
                var node_right : Option<Node_tree<T>> = Node_tree<T>(ly[index])
                index++
                tmp_que[count].getOrThrow().left = node_left 
                tmp_que[count].getOrThrow().right = node_right
                node_left.getOrThrow().up = tmp_que[count]
                node_right.getOrThrow().up = tmp_que[count]
                tmp_que.add(node_left)
                tmp_que.add(node_right)
                count ++
            }
            else if (len - index <= 1){
                // tmp = tmp_que[0]
                // tmp_que.remove(at:0)
                var node_left:Option<Node_tree<T>> = Node_tree<T>(ly[index])
                index++
                tmp_que[count].getOrThrow().left = node_left 
                node_left.getOrThrow().up = tmp_que[count]
                tmp_que.add(node_left)
                count ++
            }
        }
        return root_node
    }
    //-------------树的四种遍历--------------
    //1 前序遍历（递归）
    public func firIter(tmp!:ArrayList<T> = ArrayList<T>([]),node!:?Node_tree<T> = this.root):ArrayList<T>{
        if (node.isSome()){
            tmp.add(node.getOrThrow().val)
            firIter(tmp:tmp,node:node.getOrThrow().left)
            firIter(tmp:tmp,node:node.getOrThrow().right)
        }
        return tmp
    }
    //2 中序遍历
    public func midIter(tmp!:ArrayList<T> = ArrayList<T>([]),node!:?Node_tree<T> = this.root):ArrayList<T>{
        if (node.isSome()){
            midIter(tmp:tmp,node:node.getOrThrow().left)
            tmp.add(node.getOrThrow().val)
            midIter(tmp:tmp,node:node.getOrThrow().right)
        }
        return tmp
    }
    //3 后序遍历
    public func endIter(tmp!:ArrayList<T> = ArrayList<T>([]),node!:?Node_tree<T> = this.root):ArrayList<T>{
        if (node.isSome()){
            endIter(tmp:tmp,node:node.getOrThrow().left)
            endIter(tmp:tmp,node:node.getOrThrow().right)
            tmp.add(node.getOrThrow().val)
        }
        return tmp
    }
    //4 层次遍历
    public func levelIter():ArrayList<T>{
        return this.realAll
    }


}




main(): Int64 {

    // var a = ArrayList<Int64>([1,2,3,4])
    // var tree = Tree_01<Int64>(a)
    // println(tree.root.getOrThrow().getVal())
    // println(tree.root.getOrThrow().nextLeft().getOrThrow().getVal())
    // println(tree.root.getOrThrow().nextRight().getOrThrow().getVal())
    // println(tree.root.getOrThrow().nextLeft().getOrThrow().nextLeft().getOrThrow().getVal())
    // // println(tree.root.getOrThrow().nextLeft().getOrThrow().nextRight().getOrThrow().getVal())
    

    var a = ArrayList<String>(['a','b','c','d','e','f','g','h','i'])
    var tree = Tree_01<String>(a)
    println(tree.root.getOrThrow().getVal())
    println(tree.root.getOrThrow().nextLeft().getOrThrow().getVal())
    println(tree.root.getOrThrow().nextRight().getOrThrow().getVal())
    println(tree.root.getOrThrow().nextLeft().getOrThrow().nextLeft().getOrThrow().getVal())
    println(tree.root.getOrThrow().nextLeft().getOrThrow().nextLeft().getOrThrow().up.getOrThrow().val) //测试根的父节点
    // println(tree.root.getOrThrow().nextLeft().getOrThrow().nextRight().getOrThrow().getVal())

    var fir = tree.firIter()
    var mid = tree.midIter()
    var end = tree.endIter()
    var leval = tree.levelIter()
    println(fir)
    println(mid)
    println(end)
    println(leval)
    println(tree)  //测试是否实现ToString接口

    return 0
}


// 0,1,2,3,4,5,6
// 1,2,3,4,5,6,7
