class PolyTreeNode
    def initialize(value, children = [])
        @value = value
        @children = []
        @parent = nil
    end

    attr_reader :value, :children, :parent

    def parent=(node)
        @parent.children.delete(self) unless @parent.nil?
        @parent = node 
        @parent.children << self unless @parent.nil?
    end

    def add_child(child_node)
        child_node.parent = self    
    end

    def remove_child(child_node)
        if self.children.include?(child_node)
            child_node.parent = nil
        else
            raise
        end
    end

    def dfs(target)
        return self if self.value == target
        
        self.children.each do |child|
            result = child.dfs(target)
            return result unless result.nil?
        end
        
        nil
    end

    def bfs(target)
        q = [self]
        
        until q.empty?
            current = q.shift
            return current if current.value == target
            current.children.each { |child| q.push(child) }
        end
    end
end